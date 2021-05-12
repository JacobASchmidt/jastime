#include <jastime/jastime.h>
#include <jasio/jasio.h>
#include <stdio.h>
#include <unistd.h>

struct jasio jasio;

void puts_(int timerfd, void *str, enum jastime_status status)
{
	static int i = 0;
	printf("i: %d\n", i);
	if (i++ > 10) {
		jastime_remove(&jasio, timerfd);
		return;
	}
	puts((const char *)str);
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

	jastime_every(&jasio, jastime_seconds(1), sec);
	jastime_every(&jasio, jastime_seconds(2), two_sec);

	jasio_run(&jasio, -1);
}