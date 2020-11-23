/*
 * image_analysis.c
 *
 *  Created on: Nov 6, 2020
 *      Author: Baptiste Rossigneux & Axel Farrugia
 */

#include <stdint.h>

void Draw_Blue_Cross(int x, int y, int thickness, uint16_t* photo_buffer){
	//Horizontal blue line
	if(y < thickness) y = thickness;
	for(int i=0; i<320;i++){
		for(int j=-thickness; j<thickness; j++){
			photo_buffer[((y+j)*320)+i] = 0x001F;
		}
	}
	//Vertical blue line
	for(int i=0; i<240;i++){
	  for(int j=-thickness; j<thickness; j++){
		  photo_buffer[(x+j)+(320*i)] = 0x001F;
	  }
	}
}

void Filter_Colors_And_Get_Center(uint16_t r_threshold, uint16_t g_threshold, uint16_t b_threshold, int nb_pixels, uint16_t* photo_buffer, int* px, int* py, int* pcount){
	int x = 0, y = 0, nb_red_pix = 0;
	int a;
	for(int i=0;i<nb_pixels; i++){
	  uint16_t rouge = photo_buffer[i] & 0xF800;
	  uint16_t vert = photo_buffer[i] & 0x07E0;
	  uint16_t bleu = photo_buffer[i] & 0x001F;

	  //if pixel is too green & too blue, set it to black
	  if(vert > g_threshold || bleu > b_threshold){
		  photo_buffer[i] = 0;
	  }
	  //if pixel isn't red enough, set it to black
	  else if(rouge < r_threshold ){
		  photo_buffer[i] = 0;
	  }
	  else{
		  a = rouge/100;
		  //Translate i into x and y coordinates
		  x += i%320 * a;
		  y += i/320 * a;
		  nb_red_pix += a;
	  }
	}
	//Divide by the number of pixels to get the average of the positions
	x /= nb_red_pix;
	y /= nb_red_pix;

	//"returning" the values
	*px = x;
	*py = y;
	*pcount = nb_red_pix;

}

void Gaussian_Filter(uint16_t* photo_buffer, uint16_t* photo_blurred, int nb_pixels){
	float filter[3][3] = {
		{1/9, 1/9, 1/9} ,   /*  initializers for row indexed by 0 */
		{1/9, 1/9, 1/9} ,   /*  initializers for row indexed by 1 */
		{1/9, 1/9, 1/9}   /*  initializers for row indexed by 2 */
	};
	int x, y;
	int sum;
	uint16_t r, g, b;
	for(int i=0;i<nb_pixels; i++){
		x = i%320;
		y = i/320;
		if(x > 3 && y > 3 && x < 320 - 3 && y < 240 - 3){
			sum = 0;

			//sum += photo_buffer[i+321]*filter[0][0];
			//sum += photo_buffer[i+320]*filter[0][1];
			//sum += photo_buffer[i+319]*filter[0][2];

			sum += (photo_buffer[i] & 0xF800)/2;
			sum += (photo_buffer[i] & 0x07E0)/2;
			sum += (photo_buffer[i] & 0x001F)/2;

			sum += (photo_buffer[i+1] & 0xF800)/2;
			sum += (photo_buffer[i+1] & 0x07E0)/2;
			sum += (photo_buffer[i+1] & 0x001F)/2;
			//sum += photo_buffer[i-1]*1;

			//sum += photo_buffer[i-319]*filter[2][0];
			//sum += photo_buffer[i-320]*filter[2][1];
			//sum += photo_buffer[i-321]*filter[2][2];

			photo_blurred[i] = photo_buffer[i];

		}
		else{
			photo_blurred[i] = photo_buffer[i];
		}
	}
}
