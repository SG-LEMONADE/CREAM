import React, { FunctionComponent } from "react";

import ProductSizeSelect from "components/atoms/ProductSizeSelect";

import styled from "@emotion/styled";

type ProductSizeSelectGridProps = {
	category: "wish" | "price" | "sizeOnly";
	activeSizeOption?: string | string[];
	onClick: (size: string) => void;
	datas?: string[];
	pricePerSize?: any;
};

const ProductSizeSelectGrid: FunctionComponent<ProductSizeSelectGridProps> = (
	props,
) => {
	const { category, activeSizeOption, onClick, datas, pricePerSize } = props;

	return (
		<StyledGridWrapper>
			{category === "price" &&
				datas.map((data) =>
					data === activeSizeOption ? (
						<ProductSizeSelect
							key={data}
							category="buy"
							size={data}
							price={pricePerSize[data]}
							onClick={onClick}
							active
						/>
					) : (
						<ProductSizeSelect
							key={data}
							category="buy"
							size={data}
							price={pricePerSize[data]}
							onClick={onClick}
						/>
					),
				)}
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
				shoeAllSizeList.map((size) =>
					size === activeSizeOption ? (
						<ProductSizeSelect
							key={size}
							category="sizeOnly"
							size={size}
							onClick={onClick}
							active
						/>
					) : (
						<ProductSizeSelect
							key={size}
							category="sizeOnly"
							size={size}
							onClick={onClick}
						/>
					),
				)}
		</StyledGridWrapper>
	);
};

export default ProductSizeSelectGrid;

const StyledGridWrapper = styled.div`
    display: grid;
    padding 0 32px;
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
