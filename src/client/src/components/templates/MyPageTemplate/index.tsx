import React, { FunctionComponent } from "react";

import MyPageSidebar from "components/organisms/MyPageSidebar";

import styled from "@emotion/styled";

type MyPageTemplateProps = {
	children: React.ReactNode;
};

const MyPageTemplate: FunctionComponent<MyPageTemplateProps> = (props) => {
	const { children } = props;

	return (
		<MyPageTemplateWrapper>
			<SideNavBarArea>
				<MyPageSidebar />
			</SideNavBarArea>
			<ContentsWrapper>{children}</ContentsWrapper>
		</MyPageTemplateWrapper>
	);
};

export default MyPageTemplate;

const MyPageTemplateWrapper = styled.div`
	margin: 0 auto;
	margin-top: 100px;
	padding: 40px 40px 160px;
	max-width: 1280px;
`;

const SideNavBarArea = styled.div`
	float: left;
	width: 180px;
	margin-right: 20px;
`;

const ContentsWrapper = styled.div`
	overflow: hidden;
	min-height: 380px;
`;
