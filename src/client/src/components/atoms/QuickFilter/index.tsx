import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type QuickFilterProps = {
	content: React.ReactNode | string;
};

const QuickFilter: FunctionComponent<QuickFilterProps> = (props) => {
	const { content } = props;
	return <StyledA>{content}</StyledA>;
};

export default QuickFilter;

const StyledA = styled.a`
	display: inline-block;
	padding: 10px 12px;
	height: 38px;
	background-color: #f4f4f4;
	border-radius: 12px;
	font-size: 15px;
	letter-spacing: -0.15px;
	vertical-align: top;
`;
