import styled from "@emotion/styled";
import React, { FunctionComponent } from "react";

import colors from "../../../colors/color";

type HeaderTopItemProps = {
	children: React.ReactNode;
	onClick?: React.MouseEventHandler<HTMLLIElement>;
};

const HeaderTopItem: FunctionComponent<HeaderTopItemProps> = (props) => {
	const { children, onClick } = props;
	return <StyledList onClick={onClick}>{children}</StyledList>;
};

export default HeaderTopItem;

const StyledList = styled.li`
	list-style: none;
	color: ${colors.buttonTextColors.primary.default};
	font-size: 12px;
	cursor: pointer;
`;
