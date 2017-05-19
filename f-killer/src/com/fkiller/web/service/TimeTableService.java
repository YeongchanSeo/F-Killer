package com.fkiller.web.service;

import java.util.List;

import com.fkiller.web.entity.TimetableEntity;

public interface TimeTableService {
	public TimetableEntity oneTimetable(int userNo);
	public boolean deleteTimetable(int userNo);
	public boolean updateTimetable(TimetableEntity entity);
	public boolean insertTimetable(TimetableEntity entity);
	public TimetableEntity recommendTimetable(List<Integer>userNoList);

}
