package org.igetwell.common.lock;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Lock {

    private String name;

    private String value;
}
