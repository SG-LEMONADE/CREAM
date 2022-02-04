import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type NavTemplateProps = {
	headerTop: React.ReactNode;
	headerMain: React.ReactNode;
	children: React.ReactNode;
	footer?: React.ReactNode;
};

const NavTemplate: FunctionComponent<NavTemplateProps> = (props) => {
	const { headerTop, headerMain, children, footer } = props;
	return (
		<StyledNavWrapper>
			<StyledTopFixed>
				{headerTop && <>{headerTop}</>}
				{headerMain && <>{headerMain}</>}
			</StyledTopFixed>
			<StyledContent>{children}</StyledContent>
			{footer && <>{footer}</>}
		</StyledNavWrapper>
	);
};

export default NavTemplate;

const StyledNavWrapper = styled.div``;

const StyledTopFixed = styled.header`
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 50;
	background-color: #fff;
`;

const StyledContent = styled.main`
	position: static;
	flex: 1;
`;
