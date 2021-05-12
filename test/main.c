#include <jastime/jastime.h>
#include <jasio/jasio.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
struct jasio jasio;

void puts_(int timerfd, void *str, enum jastime_status status)
{
	puts((const char *)str);
}

void _close(int timerfd, void *data, enum jastime_status status)
{
	struct jastime *jastimes = data;
	close(jastimes[0].fd);
	close(jastimes[1].fd);
	close(timerfd);
	free(data);
	free(jastimes[0].contiunation.data);
	free(jastimes[1].contiunation.data);
}

int main()
{
	jasio_create(&jasio, 10);

	struct jastime_continuation sec;
	sec.data = "every second";
	sec.func = puts_;

	struct jastime_continuation two_sec;
	two_sec.data = "every 2 seconds";
	two_sec.func = puts_;

	struct jastime jastime_sec = jastime_every(jastime_seconds(1), sec);
	jastime_add(&jasio, jastime_sec);

	struct jastime jastime_two_sec =
		jastime_every(jastime_seconds(2), two_sec);
	jastime_add(&jasio, jastime_two_sec);

	struct jastime *jastimes = malloc(sizeof(*jastimes) * 2);
	jastimes[0] = jastime_sec;
	jastimes[1] = jastime_two_sec;

	struct jastime_continuation ten_sec;
	ten_sec.data = jastimes;
	ten_sec.func = _close;

	jastime_add(&jasio, jastime_after(jastime_seconds(10), ten_sec));

	jasio_run(&jasio, -1);
}
