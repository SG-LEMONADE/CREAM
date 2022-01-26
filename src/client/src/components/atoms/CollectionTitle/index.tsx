import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import colors from "colors/color";

type CollectionTitleProps = {
	title: string;
	subTitle?: string;
};

const CollectionTitle: FunctionComponent<CollectionTitleProps> = (props) => {
	const { title, subTitle } = props;
	return (
		<>
			<StyledTitle>{title}</StyledTitle>
			{subTitle && <StyledSubTitle>{subTitle}</StyledSubTitle>}
		</>
	);
};

export default CollectionTitle;

const StyledTitle = styled.div`
	font-size: 20px;
	letter-spacing: -0.1px;
	font-weight: 700;
	color: ${colors.colors.plain};
`;

const StyledSubTitle = styled.div`
	font-size: 14px;
	letter-spacing: -0.21px;
	color: ${colors.colors.tag};
`;
