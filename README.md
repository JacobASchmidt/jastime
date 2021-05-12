# jastime
jastime is a small extension of jasio that allows for async timers. 

## Usage

```c
struct jasio jasio;

void puts_(int timerfd, void *str, enum jastime_status status)
{
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

        //will print "every second" every second
	jastime_add(&jasio, jastime_every(jastime_second, sec));

        //will print "every two seconds" every two seconds
	jastime_add(&jasio, jastime_every(jastime_second * 2, two_sec)); 

        jasio_run(&jasio, -1);
}

```
