package com.fkiller.web.service;

import java.util.List;

import com.fkiller.web.entity.NoticeEntity;

public interface NoticeService {
	public List<NoticeEntity> teamNoticeList(int teamNo, int num);
	public int insertNotice(NoticeEntity entity);  //성공시 추가한 공지 번호 리턴. 실패시 -1 리턴.
	public boolean updateNotice(NoticeEntity entity);
	public boolean deleteNotice(int noticeNo);
	public NoticeEntity oneNotice(int noticeNo);
}
