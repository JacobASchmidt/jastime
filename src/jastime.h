#include <jasio/jasio.h>
enum jastime_status {
	JASTIME_OK = JASIO_IN,
	JASTIME_ERR = JASIO_ERR,
};
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

void jastime_after(struct jasio *jasio, long long nsec,
		   struct jastime_continuation continuation);
void jastime_every(struct jasio *jasio, long long every,
		   struct jastime_continuation contiunation);
void jastime_every_after(struct jasio *jasio, long long after, long long every,
			 struct jastime_continuation continuation);

void jastime_remove(struct jasio *jasio, int timerfd);
