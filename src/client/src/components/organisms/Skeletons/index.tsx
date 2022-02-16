import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";

const ProductSkeleton: FunctionComponent = () => {
	return (
		<SkeletonArea>
			<SkeletonWrapper>
				<SkeletonProductArea>
					<Skeleton width="100%" height={225} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
				</SkeletonProductArea>
				<SkeletonProductArea>
					<Skeleton width="100%" height={225} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
				</SkeletonProductArea>
				<SkeletonProductArea>
					<Skeleton width="100%" height={225} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
				</SkeletonProductArea>
				<SkeletonProductArea>
					<Skeleton width="100%" height={225} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
					<Skeleton width="100%" height={35} />
				</SkeletonProductArea>
			</SkeletonWrapper>
		</SkeletonArea>
	);
};

export default ProductSkeleton;

const SkeletonWrapper = styled.div`
	display: flex;
	* {
		margin-right: 10px;
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
	padding-left: max(17%, 40px);
	margin-bottom: 10%;
`;
