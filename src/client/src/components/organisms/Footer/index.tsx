import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

const Footer: FunctionComponent = () => {
	return (
		<StyledFooterWrapper>
			<StyledServiceArea>
				<ServiceArea>
					<ServiceTitle>Team Lemonade 🍋</ServiceTitle>
					<ServiceTime>
						<p>운영시간: 항시 대기중</p>
						<p>점심시간: 12:00~13:00</p>
					</ServiceTime>
					<ServiceNoti>1:1 문의하기는 직접 대면으로만 가능합니다.</ServiceNoti>
				</ServiceArea>
				<FooterMenu>
					<MenuBox>
						<MenuTitle>이용안내 😀</MenuTitle>
						<MenuList>
							<MenuItem>
								<StyledA>검수기준</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>이용정책</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>패널티 정책</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>커뮤니티 가이드라인</StyledA>
							</MenuItem>
						</MenuList>
					</MenuBox>
					<MenuBox style={{ marginLeft: "80px" }}>
						<MenuTitle>고객 지원 🧐</MenuTitle>
						<MenuList>
							<MenuItem>
								<StyledA>공지사항</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>서비스 소개</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>쇼룸 안내</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>판매자 방문접수</StyledA>
							</MenuItem>
						</MenuList>
					</MenuBox>
				</FooterMenu>
			</StyledServiceArea>
		</StyledFooterWrapper>
	);
};

export default Footer;

const StyledFooterWrapper = styled.footer`
	padding: 50px 40px;
	border-top: 1px solid #ebebeb;
`;

const StyledServiceArea = styled.div`
	display: flex;
	flex-direction: row-reverse;
	justify-content: space-between;
	padding-bottom: 56px;
	border-bottom: 1px solid #ebebeb;
`;

const ServiceArea = styled.div``;

const ServiceTitle = styled.div`
	display: inline-flex;

	align-items: center;
	font-size: 16px;
	letter-spacing: -0.16px;
	font-weight: 700;
`;

const ServiceTime = styled.div`
	padding-top: 8px;
	line-height: 17px;
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.5);
`;

const ServiceNoti = styled.div`
	padding-top: 8px;
	font-size: 13px;
	letter-spacing: -0.07px;
`;

const FooterMenu = styled.div`
	display: flex;
`;

const MenuBox = styled.div`
	width: 160px;
`;

const MenuTitle = styled.strong`
	font-size: 16px;
	letter-spacing: -0.16px;
`;

const MenuList = styled.ul`
	padding-top: 16px;
	list-style: none;
	padding: 0;
`;

const MenuItem = styled.li`
	list-style: none;
`;

const StyledA = styled.p`
	display: inline-block;
	margin: 5px 0;
	font-size: 14px;
	letter-spacing: -0.21px;
	color: rgba(34, 34, 34, 0.5);
`;
