import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type HomeTemplateProps = {
	headerTop: React.ReactNode;
	headerMain: React.ReactNode;
	children: React.ReactNode;
	footer?: React.ReactNode;
};

const HomeTemplate: FunctionComponent<HomeTemplateProps> = (props) => {
	const { headerTop, headerMain, children, footer } = props;
	return (
		<StyledHomeWrapper>
			<StyledTopFixed>
				{headerTop && <>{headerTop}</>}
				{headerMain && <>{headerMain}</>}
			</StyledTopFixed>
			<StyledContent>{children}</StyledContent>
			{footer && <>{footer}</>}
		</StyledHomeWrapper>
	);
};

export default HomeTemplate;

const StyledHomeWrapper = styled.div``;

const StyledTopFixed = styled.header`
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 1000;
	background-color: #fff;
`;

const StyledContent = styled.main`
	position: static;
	flex: 1;
`;
