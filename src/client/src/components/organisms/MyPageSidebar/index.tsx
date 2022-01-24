import React, { FunctionComponent } from "react";
import Link from "next/link";

import MyPageSiderbarItem from "components/atoms/MyPageSidebarItem";

import styled from "@emotion/styled";

const MyPageSidebar: FunctionComponent = () => {
	return (
		<MyPageSidebarWrapper>
			<Link href={"/my"} passHref>
				<StyledTitleA>
					<StyledTitle>마이 페이지</StyledTitle>
				</StyledTitleA>
			</Link>
			<nav>
				<StyledMenuArea>
					<MyPageSiderbarItem category="subtitle">쇼핑 정보</MyPageSiderbarItem>
					<Link href={"/my/buying"} passHref>
						<StyledTitleA>
							<MyPageSiderbarItem category="menu">구매 내역</MyPageSiderbarItem>{" "}
						</StyledTitleA>
					</Link>
					<Link href={"/my/selling"} passHref>
						<StyledTitleA>
							<MyPageSiderbarItem category="menu">판매 내역</MyPageSiderbarItem>
						</StyledTitleA>
					</Link>
					<Link href={"/my/wish"} passHref>
						<StyledTitleA>
							<MyPageSiderbarItem category="menu">관심 상품</MyPageSiderbarItem>
						</StyledTitleA>
					</Link>
				</StyledMenuArea>
				<StyledMenuArea>
					<MyPageSiderbarItem category="subtitle">내 정보</MyPageSiderbarItem>
					<Link href={"/my/profile"} passHref>
						<StyledTitleA>
							<MyPageSiderbarItem category="menu">
								프로필 정보
							</MyPageSiderbarItem>
						</StyledTitleA>
					</Link>
				</StyledMenuArea>
			</nav>
		</MyPageSidebarWrapper>
	);
};

export default MyPageSidebar;

const MyPageSidebarWrapper = styled.div`
	float: left;
	width: 180px;
	margin-left: 20px;
`;

const StyledTitleA = styled.a`
	text-decoration: none;
`;

const StyledTitle = styled.h2`
	line-height: 29px;
	padding-bottom: 30px;
	font-size: 24px;
	font-weight: 700;
	letter-spacing: -0.15px;
`;

const StyledMenuArea = styled.div`
	margin: 0;
	padding: 0;
	&: last-child {
		margin-top: 40px;
	}
	* {
		margin-bottom: 12px;
	}
`;
