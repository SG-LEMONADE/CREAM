import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import Image from "next/image";
import Link from "next/link";

type ShortcutItemProps = {
	bigImgSrc: string;
	smallImgSrc: string;
	link: string;
	title: string;
};

const ShortcutItem: FunctionComponent<ShortcutItemProps> = (props) => {
	const { bigImgSrc, smallImgSrc, link, title } = props;
	return (
		<StyledWrapper>
			{/* <Link href={`${link}`}>
				<a> */}
			<StyledImage
				src={bigImgSrc}
				smallsrc={smallImgSrc}
				layout="fill"
				alt={bigImgSrc}
			/>
			{/* </a>
			</Link> */}
			<StyledTitle>{title}</StyledTitle>
		</StyledWrapper>
	);
};

export default ShortcutItem;

const StyledWrapper = styled.div`
	text-align: center;
	width: calc(20% - 15px);
	height: 100px;
	display: inline-block;
	margin: 0 7.5px;
	cursor: pointer;
	position: relative;
	@media screen and (max-width: 1200px) {
		width: 100px;
		padding: ;
	}
`;

const StyledImage = styled(Image)<{ smallsrc: string }>`
	border-radius: 10px;
	height: 100px;
	@media screen and (max-width: 1200px) {
		border-radius: 50%;
		transition: 0.5s;
		content: url(${({ smallsrc }) => smallsrc});
	}
`;

const StyledTitle = styled.p`
	font-size: 15px;
	letter-spacing: -0.15px;
	color: #333;
	margin-top: 120px;
`;
