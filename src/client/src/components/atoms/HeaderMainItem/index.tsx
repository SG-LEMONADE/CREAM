import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type HeaderMainItemProps = {
	children: React.ReactNode;
	activated?: boolean;
	onClick?: React.MouseEventHandler<HTMLLIElement>;
};

const HeaderMainItem: FunctionComponent<HeaderMainItemProps> = (props) => {
	const { children, onClick, activated = false } = props;
	return (
		<StyledList activated={activated} onClick={onClick}>
			{children}
		</StyledList>
	);
};

export default HeaderMainItem;

const StyledList = styled.li<{ activated: boolean }>`
	list-style: none;
	font-size: 15px;
	cursor: pointer;
	${({ activated }) =>
		activated &&
		css`
			font-weight: 800;
		`}
`;
