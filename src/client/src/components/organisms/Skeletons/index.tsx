import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";

const ProductSkeleton: FunctionComponent = () => {
	return (
		<SkeletonArea>
			<SkeletonWrapper>
				<SkeletonProductArea>
					<ProductImgSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
				</SkeletonProductArea>
				<SkeletonProductArea>
					<ProductImgSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
				</SkeletonProductArea>
				<SkeletonProductArea>
					<ProductImgSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
				</SkeletonProductArea>
				<SkeletonProductArea>
					<ProductImgSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
					<ProductInfoSkeleton />
				</SkeletonProductArea>
			</SkeletonWrapper>
		</SkeletonArea>
	);
};

export default ProductSkeleton;

const ProductImgSkeleton = styled(Skeleton)`
	max-width: 225px;
	height: 225px;
`;

const ProductInfoSkeleton = styled(Skeleton)`
	max-width: 225px;
	height: 35px;
`;

const SkeletonWrapper = styled.div`
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	* {
		margin-right: 10px;
	}
	@media screen and (max-width: 1000px) {
		grid-template-columns: repeat(3, 1fr);
	}
	@media screen and (max-width: 880px) {
		grid-template-columns: repeat(2, 1fr);
	}
`;

const SkeletonProductArea = styled.div`
	display: flex;
	width: 15rem;
	flex-direction: column;
	* {
		margin-bottom: 5px;
	}
`;

const SkeletonArea = styled.div`
	display: flex;
	justify-content: center;
	padding-left: max(14rem, 40px);
	margin-bottom: 10%;
`;
