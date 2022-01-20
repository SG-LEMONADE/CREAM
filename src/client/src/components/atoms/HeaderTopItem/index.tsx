import React, { CSSProperties, FunctionComponent } from "react";

import styled from "@emotion/styled";
import colors from "colors/color";

type HeaderTopItemProps = {
	children: React.ReactNode;
	onClick?: React.MouseEventHandler<HTMLLIElement>;
	style?: CSSProperties;
};

const HeaderTopItem: FunctionComponent<HeaderTopItemProps> = (props) => {
	const { children, onClick, style } = props;
	return (
		<StyledList style={style} onClick={onClick}>
			{children}
		</StyledList>
	);
};

export default HeaderTopItem;

const StyledList = styled.li`
	list-style: none;
	color: ${colors.buttonTextColors.primary.default};
	font-size: 12px;
	cursor: pointer;
`;
