import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import Image from "next/image";
import Link from "next/link";

type ShortcutItemProps = {
	src: string;
	link: string;
	title: string;
};

const ShortcutItem: FunctionComponent<ShortcutItemProps> = (props) => {
	const { src, link, title } = props;
	return (
		<StyledWrapper>
			<Link href={`/${link}`}>
				<StyledImage src={src} alt={src} />
			</Link>
			<StyledTitle>{title}</StyledTitle>
		</StyledWrapper>
	);
};

export default ShortcutItem;

const StyledWrapper = styled.div`
	text-align: center;
	width: calc(20% - 15px);
	display: inline-block;
	margin: 0 7.5px;
	cursor: pointer;
`;

const StyledImage = styled(Image)`
	border-radius: 10px;
	height: 100px;
`;

const StyledTitle = styled.p`
	font-size: 15px;
	letter-spacing: -0.15px;
	color: #333;
	margin-top: 8px;
`;
