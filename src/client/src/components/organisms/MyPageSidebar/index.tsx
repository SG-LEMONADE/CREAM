import React, { FunctionComponent, useEffect, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/router";

import MyPageSiderbarItem from "components/atoms/MyPageSidebarItem";

import styled from "@emotion/styled";

const MyPageSidebar: FunctionComponent = () => {
	const router = useRouter();

	const [activatedMenu] = useState<string>(
		router.pathname.length > 4 ? router.pathname.slice(4) : "",
	);

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
							<MyPageSiderbarItem
								activated={activatedMenu === "buying"}
								category="menu"
							>
								구매 내역
							</MyPageSiderbarItem>
						</StyledTitleA>
					</Link>
					<Link href={"/my/selling"} passHref>
						<StyledTitleA>
							<MyPageSiderbarItem
								category="menu"
								activated={activatedMenu === "selling"}
							>
								판매 내역
							</MyPageSiderbarItem>
						</StyledTitleA>
					</Link>
					<Link href={"/my/wish"} passHref>
						<StyledTitleA>
							<MyPageSiderbarItem
								category="menu"
								activated={activatedMenu === "wish"}
							>
								관심 상품
							</MyPageSiderbarItem>
						</StyledTitleA>
					</Link>
				</StyledMenuArea>
				<StyledMenuArea>
					<MyPageSiderbarItem category="subtitle">내 정보</MyPageSiderbarItem>
					<Link href={"/my/profile"} passHref>
						<StyledTitleA>
							<MyPageSiderbarItem
								category="menu"
								activated={activatedMenu === "profile"}
							>
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

const MyPageSidebarWrapper = styled.div``;

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
