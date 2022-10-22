package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

public class TimerMapper {
    @Select("SELECT sysdate FROM dual")
    public String getTime();
}
