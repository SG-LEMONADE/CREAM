import React, { FunctionComponent, useState } from "react";

import styled from "@emotion/styled";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";
import Button from "components/atoms/Button";
import { useRouter } from "next/router";

type SizeSelectTemplateProps = {
	category: "buy" | "sell";
	id: number;
	imgSrc: string;
	backgroundColor: string;
	styledCode: string;
	originalName: string;
	translatedName: string;
	sizes: string[];
	pricePerSize: any;
};

const SizeSelectTemplate: FunctionComponent<SizeSelectTemplateProps> = (
	props,
) => {
	const router = useRouter();

	const {
		category,
		id,
		imgSrc,
		backgroundColor,
		styledCode,
		originalName,
		translatedName,
		sizes,
		pricePerSize,
	} = props;

	const [selectedSize, setSelectedSize] = useState<string>("");

	return (
		<SizeSelectBackground>
			<SizeSelectWrapper>
				<SizeSelectBigGrid>
					<ProductSmallInfo
						big
						imgSrc={imgSrc}
						backgroundColor={backgroundColor}
						styleCode={styledCode}
						productName={originalName}
						productNameKor={translatedName}
						style={{
							borderBottom: "1px solid #eeeeee",
							paddingBottom: "10px",
							marginBottom: "10px",
						}}
					/>
					<ProductSizeGridWrapper>
						<ProductSizeSelectGrid
							category="price"
							subCategory={category}
							datas={sizes}
							pricePerSize={pricePerSize}
							onClick={(size) => setSelectedSize(size)}
							activeSizeOption={selectedSize}
						/>
					</ProductSizeGridWrapper>
					<ButtonWrapper>
						{selectedSize === "" ? (
							<Button fullWidth disabled category="primary">
								사이즈를 선택해주세요
							</Button>
						) : (
							<Button
								fullWidth
								category={
									pricePerSize[selectedSize] === null
										? `primary`
										: `${category}`
								}
								onClick={() => {
									router.push({
										pathname: `/${category}/${id}?size=${selectedSize}`,
									});
								}}
							>
								{pricePerSize[selectedSize] !== null &&
									`${pricePerSize[selectedSize].toLocaleString()}원`}
								{pricePerSize[selectedSize] === null && `구매 입찰`}
							</Button>
						)}
					</ButtonWrapper>
				</SizeSelectBigGrid>
			</SizeSelectWrapper>
		</SizeSelectBackground>
	);
};

export default SizeSelectTemplate;

const SizeSelectBackground = styled.div`
	background-color: #fafafa;
`;

const SizeSelectWrapper = styled.div`
	overflow: hidden;
	max-width: 780px;
	min-height: 900px;
	margin: 0 auto;
	padding: 20px 40px 160px;
`;

const SizeSelectBigGrid = styled.div`
	padding: 32px 32px 28px;
	box-shadow: 0 4px 10px 0 rgb(0 0 0 / 10%);
	background-color: #fff;
`;

const ProductSizeGridWrapper = styled.div`
	position: relative;
	min-height: 484px;
	margin: 20px 0;
`;

const ButtonWrapper = styled.div`
	display: flex;
	padding-top: 20px;
	border-top: 1px solid #ebebeb;
	background-color: #fff;
`;
