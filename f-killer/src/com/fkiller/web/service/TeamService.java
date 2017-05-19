package com.fkiller.web.service;

import java.util.List;

import com.fkiller.web.entity.ProfessorEntity;
import com.fkiller.web.entity.TeamEntity;
import com.fkiller.web.entity.WorkInEntity;
import com.fkiller.web.vo.JobReportVo;
import com.fkiller.web.vo.MeetingReportVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

public interface TeamService {
		int createTeam(TeamEntity team,ProfessorEntity professor,WorkInEntity work);
		boolean insertMemeber(WorkInEntity entity);
		boolean updateTeam(TeamEntity team,ProfessorEntity professor,WorkInEntity work);
		TeamVo oneTeam(int teamNo, int userNo);
		List<JobReportVo> getJobReport(int teamNo);
		List<MeetingReportVo> getMeetingReport(int teamNo);
		List<TeamMemberVo> teamMemberList(int teamNo);
		boolean isLeader(int teamNo,int userNo);
		boolean changeTeamLeader(int teamNo,int userNo);
		ProfessorEntity getProfessorInfo(int teamNo);
		int getMaxTeamNo();
		List<TeamVo> getTeamList();
}
