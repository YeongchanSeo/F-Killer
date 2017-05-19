package com.fkiller.web.service;

import java.util.List;

import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.vo.FileVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

public interface ManageService {
		List<TeamVo> getTeamList();
		List<UserEntity> getUserList();
		List<FileVo> getFileList();
		List<TeamMemberVo> getTeamMember(int teamNo);
		TeamVo oneTeam(int teamNo);
		FileVo oneFile(int fileNo);
		UserEntity oneUser(int userNo);
}
