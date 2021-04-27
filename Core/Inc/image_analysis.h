/*
 * image_analysis.h
 *
 *  Created on: Nov 6, 2020
 *      Author: Baptiste
 */

#ifndef INC_IMAGE_ANALYSIS_H_
#define INC_IMAGE_ANALYSIS_H_

#include "arm_math.h"

void Draw_Blue_Cross(int x, int y, int thickness, uint16_t* photo_buffer);
void Filter_Colors_And_Get_Center(uint16_t r_threshold, uint16_t g_threshold, uint16_t b_threshold, int nb_pixels, uint16_t* photo_buffer, int* px, int* py, int* pcount);
void Gaussian_Filter(uint16_t* photo_buffer, uint16_t* photo_blurred, int nb_pixels);
void Gaussian_Filter_Fast(uint16_t* photo_buffer, q15_t* kernel, uint32_t size_kernel, uint16_t* photo_blurred, int nb_pixels);
#endif /* INC_IMAGE_ANALYSIS_H_ */
