import React, { FunctionComponent } from "react";
import { useRouter } from "next/router";
import Image from "next/image";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type BannerProps = {
	links?: string;
	bgColor: string;
	category: "big" | "small";
	moreHeight?: boolean;
	readonly src: string;
};

const BannerImage: FunctionComponent<BannerProps> = (props) => {
	const { links, bgColor, category, src, moreHeight } = props;
	const router = useRouter();
	return (
		<StyledBannerWrapper category={category} bgColor={bgColor}>
			<StyledImage
				width={category === "small" ? "400%" : "100%"}
				height={moreHeight ? `60%` : `30%`}
				layout="responsive"
				category={category}
				src={src}
				alt={src}
				objectFit="contain"
			/>
		</StyledBannerWrapper>
	);
};

export default BannerImage;

const StyledBannerWrapper = styled.div<{ category: string; bgColor: string }>`
	overflow: hidden;
	vertical-align: top;
	cursor: pointer;
	max-height: ${({ category }) => (category === "big" ? `480px;` : `100px`)};
	text-align: center;
	background-color: ${({ bgColor }) => bgColor};
	${({ category }) =>
		category === "small" &&
		css`
			max-width: 1200px;
		`};
`;

const StyledImage = styled(Image)<{ category: string }>`
	top: 0;
	width: auto;
	max-height: ${({ category }) => (category === "big" ? `480px;` : `100px`)};
	max-width: 80%;
`;
