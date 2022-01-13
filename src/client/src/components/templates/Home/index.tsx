import React, { FunctionComponent } from "react";
import styled from "@emotion/styled";

type HomeProps = {
	header: React.ReactNode;
	children: React.ReactNode;
	footer?: React.ReactNode;
};

const Home: FunctionComponent<HomeProps> = (props) => {
	const { header, children, footer } = props;
	return (
		<StyledHomeWrapper>
			{header && <>{header}</>}
			<StyledContent>{children}</StyledContent>
			{footer && <>{footer}</>}
		</StyledHomeWrapper>
	);
};

export default Home;

const StyledHomeWrapper = styled.div``;

const StyledContent = styled.main`
	flex: 1;
`;
