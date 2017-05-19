package com.fkiller.web.service;

import java.util.List;

import com.fkiller.web.contants.AlarmType;
import com.fkiller.web.entity.AlarmEntity;
import com.fkiller.web.vo.AlarmVo;

public interface AlarmService {
	public List<AlarmVo> teamAlarmList(int userNo,int teamNo);
	public List<AlarmVo> personalAlarmList(int userNo);
	public boolean insertAlarm(AlarmType type,AlarmEntity entity);
	public boolean deleteAlarm(AlarmType type,int alarmNo);
}
