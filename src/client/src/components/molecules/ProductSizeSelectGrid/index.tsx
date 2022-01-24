import React, { FunctionComponent } from "react";

import { SalesOptionsRes } from "types";
import ProductSizeSelect from "components/atoms/ProductSizeSelect";

import styled from "@emotion/styled";

type ProductSizeSelectGridProps = {
	category: "wish" | "price";
	activeSizeOption: string | string[];
	onClick: () => void;
	datas: SalesOptionsRes[] | string[];
};

const ProductSizeSelectGrid: FunctionComponent<ProductSizeSelectGridProps> = (
	props,
) => {
	const { category, activeSizeOption, onClick, datas } = props;

	return (
		<StyledGridWrapper>
			{category === "price" &&
				datas.map((data) =>
					data.option === activeSizeOption ? (
						<ProductSizeSelect
							key={data.option}
							category="buy"
							size={data.option}
							price={data.lowest_normal}
							onClick={onClick}
							active
						/>
					) : (
						<ProductSizeSelect
							key={data.option}
							category="buy"
							size={data.option}
							price={data.lowest_normal}
							onClick={onClick}
						/>
					),
				)}
			{category === "wish" &&
				datas.map((data) =>
					activeSizeOption.includes(data) ? (
						<ProductSizeSelect key={data} category="wish" size={data} active />
					) : (
						<ProductSizeSelect key={data} category="wish" size={data} />
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
