#include "jastime.h"
#include <sys/timerfd.h>
#include <sys/epoll.h>
#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
void after_continuation_func(int fd, void *data, enum jasio_events events)
{
	struct jastime_continuation *cont = data;
	(*cont->func)(fd, cont->data, (enum jastime_status)events);
}
void jastime_after(struct jasio *jasio, long long nsec,
		   struct jastime_continuation continuation)
{
	struct itimerspec s;
	s.it_value.tv_nsec = nsec % 1000000;
	s.it_value.tv_sec = nsec / 1000000;
	s.it_interval.tv_nsec = 0;
	s.it_interval.tv_sec = 0;
	int fd = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
	timerfd_settime(fd, 0, &s, NULL);

	struct jastime_continuation *time_continuation =
		malloc(sizeof(time_continuation));
	*time_continuation = continuation;

	struct jasio_continuation io_continuation;
	io_continuation.data = time_continuation;
	io_continuation.func = after_continuation_func;

	jasio_add(jasio, fd, JASIO_IN, io_continuation);
}

void every_continuation_func(int fd, void *data, enum jasio_events events)
{
	struct jastime_continuation *cont = data;
	if (events & JASIO_IN) {
		long long buff;
		int n = read(fd, &buff, sizeof(buff));
		if (n != 8) {
			(*cont->func)(fd, cont->data, JASTIME_ERR);
			return;
		}
	}
	(*cont->func)(fd, cont->data, (enum jastime_status)events);
}

void jastime_every_after(struct jasio *jasio, long long first, long long every,
			 struct jastime_continuation continuation)
{
	struct itimerspec s;

	s.it_value.tv_nsec = first % 1000000;
	s.it_value.tv_sec = first / 1000000;
	s.it_interval.tv_nsec = every % 1000000;
	s.it_interval.tv_sec = every / 1000000;
	int fd = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
	timerfd_settime(fd, 0, &s, NULL);

	struct jastime_continuation *time_continuation =
		malloc(sizeof(time_continuation));
	*time_continuation = continuation;

	struct jasio_continuation io_continuation;
	io_continuation.data = time_continuation;
	io_continuation.func = every_continuation_func;

	jasio_add(jasio, fd, JASIO_IN, io_continuation);
}

void jastime_every(struct jasio *jasio, long long every,
		   struct jastime_continuation contiunation)
{
	jastime_every_after(jasio, JASTIME_IMMEDIATELY, every, contiunation);
}

void jastime_remove(struct jasio *jasio, int timerfd)
{
	close(timerfd);
	jasio_remove(jasio, timerfd);
}
