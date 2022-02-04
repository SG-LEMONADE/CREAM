import React, { FunctionComponent } from "react";

import Icon from "../Icon";

import styled from "@emotion/styled";

type TagItemProps = {
	children: React.ReactNode;
	onClick: () => void;
};

const TagItem: FunctionComponent<TagItemProps> = (props) => {
	const { children, onClick } = props;

	return (
		<TagItemWrapper>
			<StyledSpan onClick={onClick}>{children}</StyledSpan>
			<Icon
				name="Close"
				style={{ width: "12px", height: "12px", color: "#bbbbbb" }}
			/>
		</TagItemWrapper>
	);
};

export default TagItem;

const TagItemWrapper = styled.div`
	display: inline-flex;
	align-items: center;
	margin: 8px 8px 0 0;
	padding: 8px 2px 8px 10px;
	background-color: #f4f4f4;
	border-radius: 6px;
	cursor: pointer;
`;

const StyledSpan = styled.span`
	font-size: 12px;
	letter-spacing: -0.05px;
	margin-right: 5px;
`;
