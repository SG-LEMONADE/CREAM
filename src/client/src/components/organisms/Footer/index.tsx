import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

const Footer: FunctionComponent = () => {
	return (
		<StyledFooterWrapper style={{}}>
			<StyledServiceArea>
				<ServiceArea>
					<ServiceTitle>Team Lemonade ๐</ServiceTitle>
					<ServiceTime>
						<p>์ด์์๊ฐ: ํญ์ ๋๊ธฐ์ค</p>
						<p>์ ์ฌ์๊ฐ: 12:00~13:00</p>
					</ServiceTime>
					<ServiceNoti>1:1 ๋ฌธ์ํ๊ธฐ๋ ์ง์  ๋๋ฉด์ผ๋ก๋ง ๊ฐ๋ฅํฉ๋๋ค.</ServiceNoti>
				</ServiceArea>
				<FooterMenu>
					<MenuBox>
						<MenuTitle>์ด์ฉ์๋ด ๐</MenuTitle>
						<MenuList>
							<MenuItem>
								<StyledA>๊ฒ์๊ธฐ์ค</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>์ด์ฉ์ ์ฑ</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>ํจ๋ํฐ ์ ์ฑ</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>์ปค๋ฎค๋ํฐ ๊ฐ์ด๋๋ผ์ธ</StyledA>
							</MenuItem>
						</MenuList>
					</MenuBox>
					<MenuBox style={{ marginLeft: "80px" }}>
						<MenuTitle>๊ณ ๊ฐ ์ง์ ๐ง</MenuTitle>
						<MenuList>
							<MenuItem>
								<StyledA>๊ณต์ง์ฌํญ</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>์๋น์ค ์๊ฐ</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>์ผ๋ฃธ ์๋ด</StyledA>
							</MenuItem>
							<MenuItem>
								<StyledA>ํ๋งค์ ๋ฐฉ๋ฌธ์ ์</StyledA>
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
	width: 100%;
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
