/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemBracket : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <QCustomPlot/src/items/item-bracket.h>
%End
public:
  enum BracketStyle { bsSquare  ///< A brace with angled edges
                      ,bsRound  ///< A brace with round edges
                      ,bsCurly  ///< A curly brace
                      ,bsCalligraphic ///< A curly brace with varying stroke width giving a calligraphic impression
  };

  explicit QCPItemBracket(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemBracket();
  
  // getters:
  QPen pen() const;
  QPen selectedPen() const;
  double length() const;
  BracketStyle style() const;
  
  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  void setLength(double length);
  void setStyle(BracketStyle style);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  QCPItemPosition * left /NoSetter/;
  QCPItemPosition * right /NoSetter/;
  QCPItemAnchor * center /NoSetter/;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual QPointF anchorPixelPosition(int anchorId) const;

  // non-virtual methods:
  QPen mainPen() const;
};
