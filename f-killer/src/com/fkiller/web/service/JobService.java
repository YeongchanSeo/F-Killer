package com.fkiller.web.service;

import java.util.List;

import com.fkiller.web.entity.CommentEntity;
import com.fkiller.web.entity.FileEntity;
import com.fkiller.web.entity.JobEntity;
import com.fkiller.web.vo.FileAdminVo;
import com.fkiller.web.vo.FileVo;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.TeamJobListVo;

public interface JobService {
		int insertJob(JobEntity entity,List<FileEntity>fileList); //성공시 추가한 업무 번호 리턴. 실패시 -1 리턴.
		boolean deleteJob(int jobNo);
		boolean updateJob(JobEntity entity);
		boolean insertComment(CommentEntity entity);
		boolean updateComment(CommentEntity entity);
		JobVo oneJob(int jobNo);
		List<JobVo> teamJobList(int userNo,int teamNo);
		List<JobVo> teamJobList(int teamNo);
		boolean insertFile(FileEntity entity);
		FileVo oneFile(int fileNo);
		List<FileVo> teamFileList(int teamNo);
		List<TeamJobListVo> teamJobCalendar(int teamNo);
		int getWorkInNo(int userNo,int teamNo);
		List<FileVo> getFileList();
		List<FileAdminVo> getAdminFileList();
		boolean updateFile(List<FileEntity> fileList);
		boolean deleteFile(int fileNo);
}
