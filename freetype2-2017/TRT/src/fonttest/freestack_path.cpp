/* Copyright 2016 Unicode Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <string>

#include <ft2build.h>
#include FT_IMAGE_H
#include FT_OUTLINE_H

#include "fonttest/freestack_path.h"

namespace fonttest {

FreeTypePathConverter::FreeTypePathConverter(const FT_Vector& transform)
  : transform_(transform) {
}

FreeTypePathConverter::~FreeTypePathConverter() {
}

std::string FreeTypePathConverter::Convert(FT_Outline* outline) {
  path_.clear();
  start_.x = start_.y = 0;
  closed_ = true;

  FT_Outline_Funcs callbacks;
  callbacks.move_to = &FreeTypePathConverter::MoveToCallback;
  callbacks.line_to = &FreeTypePathConverter::LineToCallback;
  callbacks.conic_to = &FreeTypePathConverter::QuadToCallback;
  callbacks.cubic_to = &FreeTypePathConverter::CurveToCallback;
  callbacks.shift = 0;
  callbacks.delta = 0;
  FT_Error error =
      FT_Outline_Decompose(outline, &callbacks, static_cast<void*>(this));
  if (error) {
    std::cerr << "FT_Outline_Decompose() failed; error: " << error
	      << std::endl;
    exit(1);
  }
  if (!closed_) {
    path_.append(" Z");
  }
  return path_;
}

void FreeTypePathConverter::MoveTo(const FT_Vector& to) {
  start_.x = to.x + transform_.x;
  start_.y = to.y + transform_.y;
  if (!closed_) {
    path_.append(" Z");
  }
  char buffer[200];
  snprintf(buffer, sizeof(buffer), "%sM%ld,%ld",
           path_.empty() ? "" : " ", start_.x / 64, start_.y / 64);
  path_.append(buffer);
  closed_ = false;
}

void FreeTypePathConverter::LineTo(const FT_Vector& to) {
  FT_Vector p;
  p.x = to.x + transform_.x;
  p.y = to.y + transform_.y;
  if (p.x == start_.x && p.y == start_.y) {
    path_.append(" Z");
    closed_ = true;
    return;
  }
  char buffer[200];
  snprintf(buffer, sizeof(buffer), "%sL%ld,%ld",
           path_.empty() ? "" : " ", p.x / 64, p.y / 64);
  path_.append(buffer);
  closed_ = false;
}

void FreeTypePathConverter::QuadTo(const FT_Vector& control,
                                   const FT_Vector& to) {
  char buffer[200];
  snprintf(buffer, sizeof(buffer), "%sQ%ld,%ld %ld,%ld",
           path_.empty() ? "" : " ",
	   (control.x + transform_.x) / 64, (control.y + transform_.y) / 64,
           (to.x + transform_.x) / 64, (to.y + transform_.y) / 64);
  path_.append(buffer);
  closed_ = false;
}

void FreeTypePathConverter::CurveTo(const FT_Vector& control1,
                                    const FT_Vector& control2,
                                    const FT_Vector& to) {
  char buffer[200];
  snprintf(buffer, sizeof(buffer), "%sC%ld,%ld %ld,%ld %ld,%ld",
           path_.empty() ? "" : " ",
           (control1.x + transform_.x) / 64, (control1.y + transform_.y) / 64,
           (control2.x + transform_.x) / 64, (control2.y + transform_.y) / 64,
           (to.x + transform_.x) / 64, (to.y + transform_.y) / 64);
  path_.append(buffer);
  closed_ = false;
}


int FreeTypePathConverter::MoveToCallback(const FT_Vector* to, void* data) {
  if (to && data) {
    reinterpret_cast<FreeTypePathConverter*>(data)->MoveTo(*to);
    return 0;
  } else {
    return 1;
  }
}

int FreeTypePathConverter::LineToCallback(const FT_Vector* to, void* data) {
  if (to && data) {
    reinterpret_cast<FreeTypePathConverter*>(data)->LineTo(*to);
    return 0;
  } else {
    return 1;
  }
}

int FreeTypePathConverter::QuadToCallback(const FT_Vector* control,
					  const FT_Vector* to,
					  void* data) {
  if (control && to && data) {
    reinterpret_cast<FreeTypePathConverter*>(data)->QuadTo(*control, *to);
    return 0;
  } else {
    return 1;
  }
}

int FreeTypePathConverter::CurveToCallback(const FT_Vector* control1,
					   const FT_Vector* control2,
					   const FT_Vector* to,
					   void* data) {
  if (control1 && control2 && to && data) {
    FreeTypePathConverter* c = reinterpret_cast<FreeTypePathConverter*>(data);
    c->CurveTo(*control1, *control2, *to);
    return 0;
  } else {
    return 1;
  }
}

}  // namespace fonttest
