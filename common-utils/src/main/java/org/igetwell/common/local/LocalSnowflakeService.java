package org.igetwell.common.local;


import org.springframework.stereotype.Component;

/**
 * Created by Kevin on 2015/7/11.
 */
@Component
public class LocalSnowflakeService {

    private long workerId = 0L;
    private long sequence = 0L;

    private long twepoch = 1288834974657L;

    private long workerIdBits = 7L;
    private long maxWorkerId = -1L ^ (-1L << workerIdBits);
    private long sequenceBits = 15L;

    private long workerIdShift = sequenceBits;
    private long timestampLeftShift = sequenceBits + workerIdBits;
    private long sequenceMask = -1L ^ (-1L << sequenceBits);

    private long lastTimestamp = -1L;

    public LocalSnowflakeService() {}
    public LocalSnowflakeService(long workerId) {
        // sanity check for workerId
        if (workerId > maxWorkerId || workerId < 0) {
            throw new IllegalArgumentException(String.format("worker Id can't be greater than %d or less than 0", maxWorkerId));
        }
        this.workerId = workerId;
        System.out.println("maxWorkerId=" + maxWorkerId + " sequenceMask=" + sequenceMask);
        System.out.println(String.format("worker starting. timestamp left shift %d, worker id bits %d, sequence bits %d, workerid %d", timestampLeftShift, workerIdBits, sequenceBits, workerId));
    }
/*
    public SnowflakeService() {
        this(0, 0);
    }*/

    public synchronized long nextId() {
        long timestamp = timeGen();

        if (timestamp < lastTimestamp) {
            throw new RuntimeException(String.format("Clock moved backwards.  Refusing to generate id for %d milliseconds", lastTimestamp - timestamp));
        }

        if (lastTimestamp == timestamp) {
            sequence = (sequence + 1) & sequenceMask;
            if (sequence == 0) {
                timestamp = tilNextMillis(lastTimestamp);
            }
        } else {
            sequence = 0L;
        }

        lastTimestamp = timestamp;

        return ((timestamp - twepoch) << timestampLeftShift) | (workerId << workerIdShift) | sequence;
    }

    private long tilNextMillis(long lastTimestamp) {
        long timestamp = timeGen();
        while (timestamp <= lastTimestamp) {
            timestamp = timeGen();
        }
        return timestamp;
    }

    private long timeGen() {
        return System.currentTimeMillis();
    }

}
