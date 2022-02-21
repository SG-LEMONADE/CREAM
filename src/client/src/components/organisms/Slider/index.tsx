import React, { FunctionComponent } from "react";
import { Zoom, Fade } from "react-slideshow-image";

import Icon from "components/atoms/Icon";

import "react-slideshow-image/dist/styles.css";
import styled from "@emotion/styled";

type SliderProps = {
	productSlider?: boolean;
	small?: boolean;
	images: JSX.Element[];
};

const Slider: FunctionComponent<SliderProps> = (props) => {
	const { productSlider = false, small = false, images } = props;

	const properties = {
		duration: 4000,
		transitionDuration: 400,
		infinite: true,
		prevArrow: (
			<Icon
				name="ChevronLeft"
				style={{
					position: "absolute",
					left: "20px",
					zIndex: "49",
					cursor: "pointer",
					width: "10px",
				}}
			/>
		),
		nextArrow: (
			<Icon
				name="ChevronRight"
				style={{
					marginLeft: "-30px",
					zIndex: "49",
					cursor: "pointer",
					width: "10px",
				}}
			/>
		),
	};

	const productProperties = {
		duration: 4000,
		transitionDuration: 400,
		infinite: true,
		prevArrow: (
			<Icon
				name="ChevronLeft"
				style={{
					marginRight: "-30px",
					zIndex: "30",
					cursor: "pointer",
					width: "10px",
				}}
			/>
		),
		nextArrow: (
			<Icon
				name="ChevronRight"
				style={{
					marginLeft: "-30px",
					zIndex: "30",
					cursor: "pointer",
					width: "10px",
				}}
			/>
		),
		scale: 1.5,
	};

	return (
		<>
			{productSlider &&
				(images !== null ? (
					<StyledSlider {...productProperties}>
						{images.map((Image, index) => (
							<div key={index} className="each-slide">
								<>{Image}</>
							</div>
						))}
					</StyledSlider>
				) : (
					``
				))}
			{!productSlider &&
				(images !== null ? (
					<StyledFade small={small === true ? 1 : 0} {...properties}>
						{images !== null &&
							images.map((Image, index) => (
								<div key={index} className="each-fade">
									<>{Image}</>
								</div>
							))}
					</StyledFade>
				) : (
					``
				))}
		</>
	);
};

export default Slider;

const StyledFade = styled(Fade)<{ small: number }>`
	max-width: ${({ small }) => small === 1 && "1200px"};
	position: relative;
`;

const StyledSlider = styled(Zoom)`
	max-width: 560px;
`;
