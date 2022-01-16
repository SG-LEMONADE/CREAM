import React, { FunctionComponent, useEffect, useState } from "react";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type QuickFilterProps = {
	content: React.ReactNode | string;
	activate: boolean;
	onClick?: (content: string) => void;
};

const QuickFilter: FunctionComponent<QuickFilterProps> = (props) => {
	const { content, activate, onClick } = props;
	const [isActivate, setIsActivate] = useState<boolean>(activate);

	const onClickFilterItem = () => {
		setIsActivate(!isActivate);
		typeof content === "string" && onClick(content);
	};

	useEffect(() => {
		setIsActivate(activate);
	}, [activate]);

	return (
		<StyledA activate={isActivate} onClick={onClickFilterItem}>
			{content}
		</StyledA>
	);
};

export default QuickFilter;

const StyledA = styled.a<{ activate: boolean }>`
	display: inline-block;
	padding: 10px 12px;
	height: 38px;
	background-color: #f4f4f4;
	border-radius: 12px;
	font-size: 15px;
	letter-spacing: -0.15px;
	vertical-align: top;
	cursor: pointer;
	${({ activate }) =>
		activate &&
		css`
        background-color: #fef7f6;
        color: #f15746;
        font-weight: 700;
}
    `}
`;
