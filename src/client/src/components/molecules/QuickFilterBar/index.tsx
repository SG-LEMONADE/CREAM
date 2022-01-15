import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type QuickFilterBarProps = {};

const QuickFilterBar: FunctionComponent<QuickFilterBarProps> = (props) => {
	const { children } = props;

	return <StyledQuickFilterWrapper>{children}</StyledQuickFilterWrapper>;
};

export default QuickFilterBar;

const StyledQuickFilterWrapper = styled.section`
	overflow-x: auto;
	overflow-y: hidden;
	padding-bottom: 16px;
	white-space: nowrap;
`;
