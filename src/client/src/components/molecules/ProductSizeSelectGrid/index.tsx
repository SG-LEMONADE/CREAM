import React, { FunctionComponent } from "react";

import ProductSizeSelect from "components/atoms/ProductSizeSelect";

import styled from "@emotion/styled";

type ProductSizeSelectGridProps = {
	category: "wish" | "price" | "sizeOnly";
	subCategory?: "buy" | "sell";
	activeSizeOption?: string | string[];
	onClick: (size: string) => void;
	datas?: string[];
	pricePerSize?: any;
};

const ProductSizeSelectGrid: FunctionComponent<ProductSizeSelectGridProps> = (
	props,
) => {
	const {
		category,
		subCategory,
		activeSizeOption,
		onClick,
		datas,
		pricePerSize,
	} = props;

	/** For Code Review
	 * 신발 사이즈 / 사이즈 & 찜 아이콘 / 사이즈 & 가격 으로 구성된 그리드 컴포넌트를 담당합니다.
	 * category를 통해서 3가지 기능에 대해서 담당을 하며,
	 * 그리드를 구성하는 컴포넌트 또한 ProductSizeSelect 컴포넌트를 재사용하여 구성합니다.
	 */
	return (
		<StyledGridWrapper>
			{category === "price" &&
				datas.map((data) => (
					<ProductSizeSelect
						key={data}
						category={subCategory}
						size={data}
						price={pricePerSize[data]}
						onClick={onClick}
						active={data === activeSizeOption}
					/>
				))}
			{category === "wish" &&
				datas.map((data) =>
					activeSizeOption && activeSizeOption.includes(data) ? (
						<ProductSizeSelect
							key={data}
							category="wish"
							size={data}
							onClick={onClick}
							active
						/>
					) : (
						<ProductSizeSelect
							key={data}
							category="wish"
							size={data}
							onClick={onClick}
						/>
					),
				)}
			{category === "sizeOnly" &&
				shoeAllSizeList.map((size) => (
					<ProductSizeSelect
						key={size}
						category="sizeOnly"
						size={size}
						onClick={onClick}
						active={size === activeSizeOption}
					/>
				))}
		</StyledGridWrapper>
	);
};

export default ProductSizeSelectGrid;

const StyledGridWrapper = styled.div`
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 10px 10px;
`;

const shoeAllSizeList = [
	"220",
	"225",
	"230",
	"235",
	"240",
	"245",
	"250",
	"255",
	"260",
	"265",
	"270",
	"275",
	"280",
	"285",
	"290",
	"300",
];
