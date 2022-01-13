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
			{headerTop && <>{headerTop}</>}
			{headerMain && <>{headerMain}</>}
			<StyledContent>{children}</StyledContent>
			{footer && <>{footer}</>}
		</StyledHomeWrapper>
	);
};

export default HomeTemplate;

const StyledHomeWrapper = styled.div``;

const StyledContent = styled.main`
	flex: 1;
`;
