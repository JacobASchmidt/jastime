#include <jastime/jastime.h>
#include <jasio/jasio.h>
#include <stdio.h>
#include <stdlib.h>
struct jasio jasio;

void puts_(int timerfd, void *str, enum jastime_status status)
{
	puts((const char *)str);
}

void close(int timerfd, void *data, enum jastime_status status)
{
	int *fds = data;
	jastime_remove(&jasio, fds[0]);
	jastime_remove(&jasio, fds[1]);
	jastime_remove(&jasio, timerfd);
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

	int one_sec_fd = jastime_every(&jasio, jastime_seconds(1), sec);
	int two_sec_fd = jastime_every(&jasio, jastime_seconds(2), two_sec);

	int *fds = malloc(sizeof(int) * 2);
	fds[0] = one_sec_fd;
	fds[1] = two_sec_fd;
	struct jastime_continuation ten_sec;
	ten_sec.data = fds;
	ten_sec.func = close;
	jastime_after(&jasio, jastime_seconds(10), ten_sec);

	jasio_run(&jasio, -1);
}