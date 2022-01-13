import React, { FunctionComponent } from "react";
import styled from "@emotion/styled";

type HomeTemplateProps = {
	header: React.ReactNode;
	children: React.ReactNode;
	footer?: React.ReactNode;
};

const HomeTemplate: FunctionComponent<HomeTemplateProps> = (props) => {
	const { header, children, footer } = props;
	return (
		<StyledHomeWrapper>
			{header && <>{header}</>}
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
