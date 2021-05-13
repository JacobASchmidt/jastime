#include "jastime.h"
#include <sys/timerfd.h>
#include <sys/epoll.h>
#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

void after_continuation_func(int fd, void *data, enum jasio_events events)
{
	struct jastime_continuation *cont = data;
	(*cont->func)(fd, cont->data, (enum jastime_status)events);
}
#define NANO_SEC_PER_SEC ((long long)1000000000)
struct jastime jastime_after(long long nsec,
			     struct jastime_continuation continuation)
{
	struct itimerspec s;
	s.it_value.tv_nsec = nsec % NANO_SEC_PER_SEC;
	s.it_value.tv_sec = nsec / NANO_SEC_PER_SEC;
	s.it_interval.tv_nsec = 0;
	s.it_interval.tv_sec = 0;
	int fd = timerfd_create(CLOCK_BOOTTIME, TFD_NONBLOCK);
	timerfd_settime(fd, 0, &s, NULL);

	struct jastime_continuation *time_continuation =
		malloc(sizeof(time_continuation));
	*time_continuation = continuation;

	struct jasio_continuation io_continuation;
	io_continuation.data = time_continuation;
	io_continuation.func = after_continuation_func;

	struct jastime jastime;
	jastime.fd = fd;
	jastime.contiunation = io_continuation;

	return jastime;
}

void every_continuation_func(int fd, void *data, enum jasio_events events)
{
	struct jastime_continuation *cont = data;
	if (events & JASIO_IN) {
		long long buff;
		int n = read(fd, &buff, sizeof(buff));
		if (n != sizeof(buff)) {
			(*cont->func)(fd, cont->data, JASTIME_ERR);
			return;
		}
	}
	(*cont->func)(fd, cont->data, (enum jastime_status)events);
}

struct jastime jastime_every_after(long long first, long long every,
				   struct jastime_continuation continuation)
{
	struct itimerspec s;

	s.it_value.tv_nsec = first % NANO_SEC_PER_SEC;
	s.it_value.tv_sec = first / NANO_SEC_PER_SEC;
	s.it_interval.tv_nsec = every % NANO_SEC_PER_SEC;
	s.it_interval.tv_sec = every / NANO_SEC_PER_SEC;
	int fd = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
	timerfd_settime(fd, 0, &s, NULL);

	struct jastime_continuation *time_continuation =
		malloc(sizeof(time_continuation));
	*time_continuation = continuation;

	struct jasio_continuation io_continuation;
	io_continuation.data = time_continuation;
	io_continuation.func = every_continuation_func;

	struct jastime jastime;
	jastime.fd = fd;
	jastime.contiunation = io_continuation;

	return jastime;
}

struct jastime jastime_every(long long every,
			     struct jastime_continuation contiunation)
{
	return jastime_every_after(every, every, contiunation);
}
