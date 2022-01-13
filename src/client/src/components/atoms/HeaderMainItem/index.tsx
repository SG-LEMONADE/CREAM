import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type HeaderMainItemProps = {
	children: React.ReactNode;
	onClick?: React.MouseEventHandler<HTMLLIElement>;
};

const HeaderMainItem: FunctionComponent<HeaderMainItemProps> = (props) => {
	const { children, onClick } = props;
	return <StyledList onClick={onClick}>{children}</StyledList>;
};

export default HeaderMainItem;

const StyledList = styled.li`
	list-style: none;
	font-size: 15px;
	cursor: pointer;
`;
