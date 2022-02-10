import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type MyPageSiderbarItemProps = {
	category: "subtitle" | "menu";
	children: React.ReactNode;
};

const MyPageSiderbarItem: FunctionComponent<MyPageSiderbarItemProps> = (
	props,
) => {
	const { category, children } = props;

	return category === "subtitle" ? (
		<StyledStrong>{children}</StyledStrong>
	) : (
		<StyledLi>
			<StyledA>{children}</StyledA>
		</StyledLi>
	);
};

export default MyPageSiderbarItem;

const StyledStrong = styled.strong`
	line-height: 22px;
	margin-bottom: 12px;
	display: inline-block;
	vertical-align: top;
	font-size: 18px;
	letter-spacing: -0.27px;
	font-weight: 700;
`;

const StyledLi = styled.li`
	list-style: none;
`;

const StyledA = styled.p`
	margin: 0;
	padding: 0;
	line-height: 18px;
	font-size: 15px;
	letter-spacing: -0.15px;
	color: rgba(34, 34, 34, 0.5);
`;
