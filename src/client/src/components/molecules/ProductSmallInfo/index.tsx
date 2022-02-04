import React, { CSSProperties, FunctionComponent } from "react";
import Image from "next/image";

import styled from "@emotion/styled";

type ProductSmallInfoProps = {
	imgSrc: string;
	backgroundColor: string;
	productName: string;
	productNameKor?: string;
	size?: string;
	style?: CSSProperties;
};

const ProductSmallInfo: FunctionComponent<ProductSmallInfoProps> = (props) => {
	const { imgSrc, backgroundColor, productName, productNameKor, style, size } =
		props;

	return (
		<ProductArea style={style}>
			<ProductThumb backgroundColor={backgroundColor}>
				<StyledImg width="100%" height="100%" src={imgSrc} />
			</ProductThumb>
			<ProductInfoArea>
				<StyledProductName>{productName}</StyledProductName>
				{size && (
					<StlyledSize>
						<StyledSpan>{size}</StyledSpan>
					</StlyledSize>
				)}
				{productNameKor && (
					<StyledProductNameKor>{productNameKor}</StyledProductNameKor>
				)}
			</ProductInfoArea>
		</ProductArea>
	);
};

export default ProductSmallInfo;

const ProductArea = styled.div`
	padding-right: 40px;
	display: flex;
`;

const ProductThumb = styled.div<{ backgroundColor: string }>`
	background-color: ${({ backgroundColor }) => backgroundColor};
	flex: none;
	margin-right: 12px;
	width: 64px;
	height: 64px;
	border-radius: 12px;
`;

const StyledImg = styled(Image)`
	vertical-align: top;
	border-radius: 12px;
`;

const ProductInfoArea = styled.div`
	display: flex;
	flex-direction: column;
	justify-content: center;
	flex: 1;
`;

const StlyledSize = styled.p`
	line-height: 19px;
	margin-top: 4px;
`;

const StyledSpan = styled.span`
	display: inline-block;
	vertical-align: top;
	font-size: 14px;
	font-weight: 700;
	letter-spacing: -0.5px;
	color: rgba(34, 34, 34, 0.5);
`;

const StyledProductName = styled.p`
	white-space: normal;
	overflow: hidden;
	text-overflow: ellipsis;
	line-height: 18px;
	font-size: 15px;
	margin: 10px 0 0 0;
`;

const StyledProductNameKor = styled.p`
	line-height: 14px;
	font-size: 12px;
	letter-spacing: -0.06px;
	color: rgba(34, 34, 34, 0.5);
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
`;
