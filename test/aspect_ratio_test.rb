require 'minitest/autorun'
require_relative '../lib/aspect_ratio'

describe AspectRatio do
  describe('.resize') do
    let(:vertical) { {x: 3456, y: 5184} }
    let(:horizontal) { {x: 5184, y: 3456} }

    let(:max_x) { 500 }
    let(:max_y) { 500 }

    describe('max_x only') do
      it('returns bounds for horizontal image') do
        bounds = AspectRatio.resize(horizontal.fetch(:x), horizontal.fetch(:y), max_x)
        bounds.must_equal([500, 333])
      end

      it('returns bounds for vertical image') do
        bounds = AspectRatio.resize(vertical.fetch(:x), vertical.fetch(:y), max_x)
        bounds.must_equal([500, 750])
      end
    end

    describe('max_y only') do
      it('returns bounds for horizontal image') do
        bounds = AspectRatio.resize(horizontal.fetch(:x), horizontal.fetch(:y), nil, max_y)
        bounds.must_equal([750, 500])
      end

      it('returns bounds for vertical image') do
        bounds = AspectRatio.resize(vertical.fetch(:x), vertical.fetch(:y), nil, max_y)
        bounds.must_equal([333, 500])
      end
    end

    describe('max_x and max_y') do
      it('returns bounds for horizontal image') do
        bounds = AspectRatio.resize(horizontal.fetch(:x), horizontal.fetch(:y), 500, 500)
        bounds.must_equal([500, 333])
      end

      it('returns bounds for vertical image') do
        bounds = AspectRatio.resize(vertical.fetch(:x), vertical.fetch(:y), 500, 500)
        bounds.must_equal([333, 500])
      end

      it('properly rounds all edges') do
        bounds = AspectRatio.resize(800, 534, 500, 500)
        bounds.must_equal([500, 334])
      end
    end
  end

  describe '.crop' do
    describe 'horizontal image' do
      # 5184 × 3456
      let(:width) { 5184 }
      let(:height) { 3456 }

      describe 'same orientation' do
        it('returns crop for 1:1 aspect ratio') do
          # 3456 × 3456
          crop = AspectRatio.crop(width, height, '1:1')
          crop.must_equal([864, 0, 3456, 3456])
        end

        it('returns crop for 3:2 aspect ratio') do
          # 5184 × 3456
          crop = AspectRatio.crop(width, height, '3:2')
          crop.must_equal([0, 0, 5184, 3456])
        end

        it('returns crop for 3:5 aspect ratio') do
          # 5184 × 3110
          crop = AspectRatio.crop(width, height, '3:5')
          crop.must_equal([0, 172, 5184, 3112])
        end

        it('returns crop for 4:3 aspect ratio') do
          # 4608 × 3456
          crop = AspectRatio.crop(width, height, '4:3')
          crop.must_equal([288, 0, 4608, 3456])
        end

        it('returns crop for 5:7 aspect ratio') do
          # 4838 × 3456
          crop = AspectRatio.crop(width, height, '5:7')
          crop.must_equal([172, 0, 4840, 3456])
        end

        it('returns crop for 8:10 aspect ratio') do
          # 4320 × 3456
          crop = AspectRatio.crop(width, height, '8:10')
          crop.must_equal([1209, 0, 2766, 3456])
        end

        it('returns crop for 16:9 aspect ratio') do
          # 5184 × 2916
          crop = AspectRatio.crop(width, height, '16:9')
          crop.must_equal([0, 270, 5184, 2916])
        end
      end

      describe 'vertical orientation' do
        it('returns crop for 1:1 aspect ratio') do
          # 3456 × 3456
          crop = AspectRatio.crop(width, height, '1:1!v')
          crop.must_equal([864, 0, 3456, 3456])
        end

        it('returns crop for 3:2 aspect ratio') do
          # 2304 × 3456
          crop = AspectRatio.crop(width, height, '3:2!v')
          crop.must_equal([1440, 0, 2304, 3456])
        end

        it('returns crop for 3:5 aspect ratio') do
          # 2074 × 3456
          crop = AspectRatio.crop(width, height, '3:5!v')
          crop.must_equal([1555, 0, 2074, 3456])
        end

        it('returns crop for 4:3 aspect ratio') do
          # 2592 × 3456
          crop = AspectRatio.crop(width, height, '4:3!v')
          crop.must_equal([1296, 0, 2592, 3456])
        end

        it('returns crop for 5:7 aspect ratio') do
          # 2469 × 3456
          crop = AspectRatio.crop(width, height, '5:7!v')
          crop.must_equal([1357, 0, 2470, 3456])
        end

        it('returns crop for 8:10 aspect ratio') do
          # 2765 × 3456
          crop = AspectRatio.crop(width, height, '8:10!v')
          crop.must_equal([1209, 0, 2766, 3456])
        end

        it('returns crop for 16:9 aspect ratio') do
          # 1944 × 3456
          crop = AspectRatio.crop(width, height, '16:9!v')
          crop.must_equal([1620, 0, 1944, 3456])
        end
      end
    end

    describe 'vertical image' do
      # 3456 x 5184
      let(:width) { 3456 }
      let(:height) { 5184 }

      describe 'same orientation' do
        it('returns crop for 1:1 aspect ratio') do
          # 3456 × 3456
          crop = AspectRatio.crop(width, height, '1:1')
          crop.must_equal([0, 864, 3456, 3456])
        end

        it('returns crop for 3:2 aspect ratio') do
          # 5184 × 3456
          crop = AspectRatio.crop(width, height, '3:2')
          crop.must_equal([0, 0, 3456, 5184])
        end

        it('returns crop for 3:5 aspect ratio') do
          # 5184 × 3110
          crop = AspectRatio.crop(width, height, '3:5')
          crop.must_equal([172, 0, 3112, 5184])
        end

        it('returns crop for 4:3 aspect ratio') do
          # 4608 × 3456
          crop = AspectRatio.crop(width, height, '4:3')
          crop.must_equal([0, 288, 3456, 4608])
        end

        it('returns crop for 5:7 aspect ratio') do
          # 4838 × 3456
          crop = AspectRatio.crop(width, height, '5:7')
          crop.must_equal([0, 172, 3456, 4840])
        end

        it('returns crop for 8:10 aspect ratio') do
          # 4320 × 3456
          crop = AspectRatio.crop(width, height, '8:10')
          crop.must_equal([0, 1209, 3456, 2766])
        end

        it('returns crop for 16:9 aspect ratio') do
          # 5184 × 2916
          crop = AspectRatio.crop(width, height, '16:9')
          crop.must_equal([270, 0, 2916, 5184])
        end
      end

      describe 'horizontal orientation' do
        it('returns crop for 1:1 aspect ratio') do
          # 3456 × 3456
          crop = AspectRatio.crop(width, height, '1:1!h')
          crop.must_equal([0, 864, 3456, 3456])
        end

        it('returns crop for 3:2 aspect ratio') do
          # 3456 × 2304
          crop = AspectRatio.crop(width, height, '3:2!h')
          crop.must_equal([0, 1440, 3456, 2304])
        end

        it('returns crop for 3:5 aspect ratio') do
          # 3456 × 2074
          crop = AspectRatio.crop(width, height, '3:5!h')
          crop.must_equal([0, 1555, 3456, 2074])
        end

        it('returns crop for 4:3 aspect ratio') do
          # 3456 × 2592
          crop = AspectRatio.crop(width, height, '4:3!h')
          crop.must_equal([0, 1296, 3456, 2592])
        end

        it('returns crop for 5:7 aspect ratio') do
          # 3456 × 2469
          crop = AspectRatio.crop(width, height, '5:7!h')
          crop.must_equal([0, 1357, 3456, 2470])
        end

        it('returns crop for 8:10 aspect ratio') do
          # 3456 × 2765
          crop = AspectRatio.crop(width, height, '8:10!h')
          crop.must_equal([0, 1209, 3456, 2766])
        end

        it('returns crop for 16:9 aspect ratio') do
          # 3456 × 1944
          crop = AspectRatio.crop(width, height, '16:9!h')
          crop.must_equal([0, 1620, 3456, 1944])
        end
      end
    end
  end
end