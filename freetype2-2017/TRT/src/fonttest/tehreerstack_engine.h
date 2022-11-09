/* Copyright 2019 Unicode Inc. All rights reserved.
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

#ifndef FONTTEST_TEHREERSTACK_ENGINE_H_
#define FONTTEST_TEHREERSTACK_ENGINE_H_

#include <map>
#include <string>

#include <ft2build.h>
#include FT_FREETYPE_H

#include "fonttest/font.h"

namespace fonttest {

class TehreerStackEngine : public FontEngine {
 public:
  TehreerStackEngine();
  ~TehreerStackEngine();
  virtual std::string GetName() const;
  virtual std::string GetVersion() const;
  virtual Font* LoadFont(const std::string& path, int faceIndex);

  // Renders a line of text into an SVG document.
  virtual bool RenderSVG(const std::string& text,
                         const std::string& textLanguage,
                         Font* font, double fontSize,
                         const FontVariation& fontVariation,
                         const std::string& idPrefix,
                         std::string* svg);

 private:
  FT_Library freeTypeLibrary_;
};

}  // namespace fonttest


#endif  // FONTTEST_TEHREERSTACK_ENGINE_H_
