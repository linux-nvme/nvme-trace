# nvme-trace
Decode nvme trace events

To use, first enable nvme trace events. To enable all of them, you can do it
like this:

  # echo 1 > /sys/kernel/debug/tracing/events/nvme/enable

This will likely fill the trace buffer rather quickly when you're tracing all
IO for even a modest workload.

You can also filter for specific things. For example, if you want to trace only
admin commands, you can do it like this:

  # echo "qid==0" > /sys/kernel/debug/tracing/events/nvme/filter

Once your trace is enabled and some commands have run, you can get the trace
and pipe it to this parsing program like this:

  # cat /sys/kernel/debug/tracing/trace | ./nvme-trace.pl
