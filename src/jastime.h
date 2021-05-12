#include <jasio/jasio.h>
enum jastime_status {
	JASTIME_OK = JASIO_IN,
	JASTIME_ERR = JASIO_ERR,
};

#define JASTIME_EVENTS JASIO_IN
struct jastime_continuation {
	void (*func)(int timer_fd, void *data, enum jastime_status status);
	void *data;
};
enum { jastime_nanosecond = 1LL,
       jastime_millisecond = 1000LL * jastime_nanosecond,
       jastime_second = 1000LL * jastime_millisecond,
       jastime_minute = 60LL * jastime_second,

       jastime_hour = 60LL * jastime_minute,
       jastime_day = 24LL * jastime_hour,
};
#define JASTIME_IMMEDIATELY jastime_nanosecond

struct jastime {
	int fd;
	struct jasio_continuation contiunation;
};
struct jastime jastime_after(long long nsec,
			     struct jastime_continuation continuation);
struct jastime jastime_every(long long every,
			     struct jastime_continuation contiunation);
struct jastime jastime_every_after(long long first, long long every,
				   struct jastime_continuation continuation);

inline int jastime_add(struct jasio *jasio, struct jastime jastime)
{
	return jasio_add(jasio, jastime.fd, JASTIME_EVENTS,
			 jastime.contiunation);
}
