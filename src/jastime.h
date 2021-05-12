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

inline long long jastime_nanoseconds(long long l)
{
	return l;
}
inline long long jastime_milliseconds(long long l)
{
	return l * 1000;
}
inline long long jastime_seconds(long long l)
{
	return jastime_milliseconds(l) * 1000;
}

inline long long jastime_minutes(long long l)
{
	return jastime_seconds(l) * 60;
}
inline long long jastime_hours(long long l)
{
	return jastime_minutes(l) * 60;
}
inline long long jastime_days(long long l)
{
	return jastime_hours(l) * 24;
}
#define JASTIME_IMMEDIATELY jastime_nanoseconds(1)

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
