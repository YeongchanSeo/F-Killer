package com.fkiller.web.service;

import java.sql.Date;
import java.util.List;

import com.fkiller.web.entity.MeetingEntity;
import com.fkiller.web.entity.PartInEntity;
import com.fkiller.web.vo.MeetingVo;

public interface MeetingService {
		List<MeetingVo> teamMeetingList(int teamNo, int done, int num);//[done]-1:예정만, 0:모두, 1:완료만   //[num]0:전부, 나머지:원하는 개수만큼
		MeetingVo oneMeeting(int meetingNo,int teamNo);
		int insertMeeting(MeetingEntity entity, List<PartInEntity>partInList);	//성공시 추가한 회의 번호 리턴. 실패시 -1 리턴.
		boolean updateMeeting(MeetingEntity entity, List<PartInEntity>partInList,int teamNo);
		boolean deleteMeeting(int meetingNo);
		boolean writeMeetingLog(MeetingEntity entity, List<PartInEntity>partInList);
		boolean hasMeeting(int teamNo, Date date);
}
